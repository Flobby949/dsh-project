<template>
  <view class="page-info">
    <!-- <comment-card :comment="commentDetailInfo" :showReply="false" :clickable="false" @click="reply(commentDetailInfo)"></comment-card> -->
    <view v-for="(item, index) in commentDetailInfo.replyList" :key="index">
      <comment-reply-item :reply="item" :parentId="commentDetailInfo.id"  @click="reply(item)" />
    </view>
    <view class="reply-bar">
      <uni-icons type="mic-filled" size="30" color="#bbbbbb" @click="showMic"></uni-icons>
      <!-- <uni-icons type="mic-filled" size="30" color="#bbbbbb"></uni-icons> -->
      <uni-easyinput class="input" v-model="commentReplyParams.content" :placeholder="placeholder"></uni-easyinput>
      <uni-icons type="paperplane-filled" size="30" color="#bbbbbb" @click="sendComment"></uni-icons>
    </view>
    <uni-popup ref="showMicFlag" background-color="#fff" @maskClick="closePopup">
      <view class="mic-bar">
        <view>{{ minutes }}:{{ seconds }}</view>
        <view :class="['mic-icon wave danger', { ripple: startMicFlag }]" @click="changeMicStatus">
            <view class="circle"></view>
            <view class="circle"></view>
            <view class="circle"></view>
            <view class="content">
              <uni-icons type="mic" size="40" color="#fff"  v-if="!startMicFlag"></uni-icons>
              <uni-icons type="mic-filled" size="40" color="#fff" v-if="startMicFlag"></uni-icons>
            </view>
        </view>
      </view>
      <view class="row">
          <view class="sendButton" @Click="closePopup" style="color: #12b089;background-color:#fff;border:#12b089 1rpx solid">
            <span>取消录音</span>
          </view>
          <view class="sendButton" @click="overPopup">
            <span>发送录音</span>
          </view>
        </view>
    </uni-popup>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import CommentCard from '../../components/CommentCard/CommentCard.vue'
import { commentDetail, forumCommentAdd } from '@/service/forum.js'
import { onLoad, onShow } from '@dcloudio/uni-app'
import CommentReplyItem from './components/CommentReplyItem.vue'
import Recorder from 'recorder-core'
import RecordApp from 'recorder-core/src/app-support/app.js'
import '@/uni_modules/Recorder-UniCore/app-uni-support.js'
import 'recorder-core/src/engine/mp3'
import 'recorder-core/src/engine/mp3-engine'

const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
})

// var vue3This=getCurrentInstance().proxy;
onLoad(() => {
  getCommentDetail()
  RecordApp.UniRenderjsRegister()
})
const commentDetailInfo = ref([])
const getCommentDetail = async () => {
  const { data } = await commentDetail(props.id)
  console.log(data);
  commentDetailInfo.value = data
  commentReplyParams.value.forumId = commentDetailInfo.value.forumId
  commentReplyParams.value.parentId = commentDetailInfo.value.id
}

const placeholder = ref('请输入评论')
const commentReplyParams = ref({
  content: '',
  type: 1
})
const reply = (comment) => {
  console.log('**************************************');
  console.log(comment);
  placeholder.value = '回复' + comment.username
  commentReplyParams.value.parentId = comment.id
}
const sendComment = async () => {
  const res = await forumCommentAdd(commentReplyParams.value)
  console.log(res)
  if (res.code === 0) {
    uni.showToast()
    uni.showLoading()
    await getCommentDetail()
    commentReplyParams.value.content = ''
    commentReplyParams.value.parentId = commentDetailInfo.value.id
    uni.hideLoading()
  } else {
    uni.showToast({
      'icon': 'error',
      'title': res.msg
    })
  }
}
const showMicFlag = ref()
const showMic = () => {
  showMicFlag.value.open('bottom')
}
const startMicFlag = ref(false)
const micTime = ref(0)
const intervalId = ref();
const minutes = computed(() => String(Math.floor(micTime.value / 60)).padStart(2, '0'));
const seconds = computed(() => String(micTime.value % 60).padStart(2, '0'));

//录音功能
//请求录音权限
const recReq = () => {
        //编译成App时提供的授权许可（编译成H5、小程序为免费授权可不填写）；如果未填写授权许可，将会在App打开后第一次调用请求录音权限时，弹出“未获得商用授权时，App上仅供测试”提示框
        //RecordApp.UniAppUseLicense='我已获得UniAppID=*****的商用授权';
        // RecordApp.RequestPermission_H5OpenSet={ audioTrackSet:{ noiseSuppression:true,echoCancellation:true,autoGainControl:true } }; //这个是Start中的audioTrackSet配置，在h5（H5、App+renderjs）中必须提前配置，因为h5中RequestPermission会直接打开录音
        RecordApp.UniWebViewActivate(this); //App环境下必须先切换成当前页面WebView
        RecordApp.RequestPermission(()=>{
            console.log("已获得录音权限，可以开始录音了");
        },(msg,isUserNotAllow)=>{
            if(isUserNotAllow){//用户拒绝了录音权限
                //这里你应当编写代码进行引导用户给录音权限，不同平台分别进行编写
            }
            console.error("请求录音权限失败："+msg);
        });
    }
    //开始录音
const recStart = () => {
    //录音配置信息
    var set={
        type:"mp3",sampleRate:16000,bitRate:16 //mp3格式，指定采样率hz、比特率kbps，其他参数使用默认配置；注意：是数字的参数必须提供数字，不要用字符串；需要使用的type类型，需提前把格式支持文件加载进来，比如使用wav格式需要提前加载wav.js编码引擎
        /*,audioTrackSet:{ //可选，如果需要同时播放声音（比如语音通话），需要打开回声消除（打开后声音可能会从听筒播放，部分环境下（如小程序、App原生插件）可调用接口切换成扬声器外放）
            //注意：H5、App+renderjs中需要在请求录音权限前进行相同配置RecordApp.RequestPermission_H5OpenSet后此配置才会生效
            echoCancellation:true,noiseSuppression:true,autoGainControl:true} */
        ,onProcess:(buffers,powerLevel,duration,sampleRate,newBufferIdx,asyncEnd)=>{
            //全平台通用：可实时上传（发送）数据，配合Recorder.SampleData方法，将buffers中的新数据连续的转换成pcm上传，或使用mock方法将新数据连续的转码成其他格式上传，可以参考Recorder文档里面的：Demo片段列表 -> 实时转码并上传-通用版；基于本功能可以做到：实时转发数据、实时保存数据、实时语音识别（ASR）等

            //注意：App里面是在renderjs中进行实际的音频格式编码操作，此处的buffers数据是renderjs实时转发过来的，修改此处的buffers数据不会改变renderjs中buffers，所以不会改变生成的音频文件，可在onProcess_renderjs中进行修改操作就没有此问题了；如需清理buffers内存，此处和onProcess_renderjs中均需要进行清理，H5、小程序中无此限制
            //注意：如果你要用只支持在浏览器中使用的Recorder扩展插件，App里面请在renderjs中引入此扩展插件，然后在onProcess_renderjs中调用这个插件；H5可直接在这里进行调用，小程序不支持这类插件；如果调用插件的逻辑比较复杂，建议封装成js文件，这样逻辑层、renderjs中直接import，不需要重复编写

            //H5、小程序等可视化图形绘制，直接运行在逻辑层；App里面需要在onProcess_renderjs中进行这些操作
            // #ifdef H5 || MP-WEIXIN
            if(this.waveView) this.waveView.input(buffers[buffers.length-1],powerLevel,sampleRate);
            // #endif
        }
        ,onProcess_renderjs:`function(buffers,powerLevel,duration,sampleRate,newBufferIdx,asyncEnd){
            //App中在这里修改buffers会改变生成的音频文件，但注意：buffers会先转发到逻辑层onProcess后才会调用本方法，因此在逻辑层的onProcess中需要重新修改一遍
            //本方法可以返回true，renderjs中的onProcess将开启异步模式，处理完后调用asyncEnd结束异步，注意：这里异步修改的buffers一样的不会在逻辑层的onProcess中生效
            //App中是在renderjs中进行的可视化图形绘制，因此需要写在这里，this是renderjs模块的this（也可以用This变量）；如果代码比较复杂，请直接在renderjs的methods里面放个方法xxxFunc，这里直接使用this.xxxFunc(args)进行调用
            if(this.waveView) this.waveView.input(buffers[buffers.length-1],powerLevel,sampleRate);
        }`
        ,onProcessBefore_renderjs:`function(buffers,powerLevel,duration,sampleRate,newBufferIdx){
            //App中本方法会在逻辑层onProcess之前调用，因此修改的buffers会转发给逻辑层onProcess，本方法没有asyncEnd参数不支持异步处理
            //一般无需提供本方法只用onProcess_renderjs就行，renderjs的onProcess内部调用过程：onProcessBefore_renderjs -> 转发给逻辑层onProcess -> onProcess_renderjs
        }`

        ,takeoffEncodeChunk:true?null:(chunkBytes)=>{
            //全平台通用：实时接收到编码器编码出来的音频片段数据，chunkBytes是Uint8Array二进制数据，可以实时上传（发送）出去
            //App中如果未配置RecordApp.UniWithoutAppRenderjs时，建议提供此回调，因为录音结束后会将整个录音文件从renderjs传回逻辑层，由于uni-app的逻辑层和renderjs层数据交互性能实在太拉跨了，大点的文件传输会比较慢，提供此回调后可避免Stop时产生超大数据回传
        }
        ,takeoffEncodeChunk_renderjs:true?null:`function(chunkBytes){
            //App中这里可以做一些仅在renderjs中才生效的事情，不提供也行，this是renderjs模块的this（也可以用This变量）
        }`

        ,start_renderjs:`function(){
            //App中可以放一个函数，在Start成功时renderjs中会先调用这里的代码，this是renderjs模块的this（也可以用This变量）
            //放一些仅在renderjs中才生效的事情，比如初始化，不提供也行
        }`
        ,stop_renderjs:`function(arrayBuffer,duration,mime){
            //App中可以放一个函数，在Stop成功时renderjs中会先调用这里的代码，this是renderjs模块的this（也可以用This变量）
            //放一些仅在renderjs中才生效的事情，不提供也行
        }`
    };
    RecordApp.UniWebViewActivate(this); //App环境下必须先切换成当前页面WebView
    RecordApp.Start(set,()=>{
        console.log("已开始录音");
        //创建音频可视化图形绘制，App环境下是在renderjs中绘制，H5、小程序等是在逻辑层中绘制，因此需要提供两段相同的代码
        //view里面放一个canvas，canvas需要指定宽高（下面style里指定了300*100）
        //<canvas type="2d" class="recwave-WaveView" style="width:300px;height:100px"></canvas>
        RecordApp.UniFindCanvas(this,[".recwave-WaveView"],`
            this.waveView=Recorder.WaveView({compatibleCanvas:canvas1, width:300, height:100});
        `,(canvas1)=>{
            this.waveView=Recorder.WaveView({compatibleCanvas:canvas1, width:300, height:100});
        });
    },(msg)=>{
        console.error("开始录音失败："+msg);
    });
}

//暂停录音
const recPause = () => {
    if(RecordApp.GetCurrentRecOrNull()){
        RecordApp.Pause();
        console.log("已暂停");
    }
}
//继续录音
const recResume = () => {
    if(RecordApp.GetCurrentRecOrNull()){
        RecordApp.Resume();
        console.log("继续录音中...");
    }
}
//结束录音
const recStop = () => {
    RecordApp.Stop((arrayBuffer,duration,mime)=>{
        //全平台通用：arrayBuffer是音频文件二进制数据，可以保存成文件或者发送给服务器
        //App中如果在Start参数中提供了stop_renderjs，renderjs中的函数会比这个函数先执行
        //注意：当Start时提供了takeoffEncodeChunk后，你需要自行实时保存录音文件数据，因此Stop时返回的arrayBuffer的长度将为0字节
        //如果是H5环境，也可以直接构造成Blob/File文件对象，和Recorder使用一致
        // #ifdef H5
            var blob=new Blob([arrayBuffer],{type:mime});
            console.log(blob, (window.URL||webkitURL).createObjectURL(blob));
            var file=new File([arrayBuffer],"recorder.mp3");
            //uni.uploadFile({file:file, ...}) //参考demo中的test_upload_saveFile.vue
        // #endif
            console.log("去传文件1");
            uploadFile((window.URL||webkitURL).createObjectURL(blob));

        //如果是App、小程序环境，可以直接保存到本地文件，然后调用相关网络接口上传
        // #ifdef APP || MP-WEIXIN
            RecordApp.UniSaveLocalFile("recorder.mp3",arrayBuffer,(savePath)=>{
                console.log(savePath); //app保存的文件夹为`plus.io.PUBLIC_DOWNLOADS`，小程序为 `wx.env.USER_DATA_PATH` 路径
                //uni.uploadFile({filePath:savePath, ...}) //参考demo中的test_upload_saveFile.vue
                // 上传
                console.log("去传文件2");
                uploadFile(savePath);
           },(errMsg)=>{ console.error(errMsg) });
        // #endif
    },(msg)=>{
        console.error("结束录音失败："+msg);
    });
}
const micCount = ref(0)
const changeMicStatus = () => {
  startMicFlag.value = !startMicFlag.value

  if (startMicFlag.value) {
    // recorderManager.start()
    startTimer()
    micCount.value = 1
  } else {
    // recorderManager.stop()
    recPause()
    stopTimer()
  }
}
const startTimer = () => {
  if(micCount.value === 0){
    recReq()
    console.log("授权录音")
    recStart()
    console.log("开始录音")
  }
  else{
    recResume()
    console.log("继续录音")
  }
  if (!intervalId.value) {
    intervalId.value = setInterval(() => {
      micTime.value++;
    }, 1000);
  }
}
const stopTimer = () => {
  clearInterval(intervalId.value);
  intervalId.value = null;
}
const resetTimer = () => {
  stopTimer();
  micTime.value = 0;
}
const closePopup = () => {
  console.log('取消录音')
  resetTimer()
  startMicFlag.value = false
  micCount.value = 0
}
const overPopup = () => {
  recStop()
  resetTimer()
  micCount.value = 0
  startMicFlag.value = false
}

const uploadFile = (file) => {
  // 文件上传
  uni.uploadFile({
    url: 'http://8.153.16.66/dsh-client-api/common/upload/img',
    name: 'file', // 后端数据字段名
    filePath: file,
    success: (res) => {
      // 判断状态码是否上传成功
      const dataList = JSON.parse(res.data)
      if (res.statusCode === 200) {
        uni.showToast({ icon: 'success', title: '上传成功' })
        console.log('上传成功')
        console.log(dataList)
        const commentData = {
              forumId: commentDetailInfo.value.forumId,
              content:'【语音消息】',
              type: 1,
              fileType: 1,
              parentId: props.id,
              files: dataList.data.urlList,
        }
        console.log(commentData)
        const rep = forumCommentAdd(commentData);
        console.log(rep);
        if (res.code === 0) {
            uni.showToast()
            uni.showLoading()
            // await getCommentList()
            uni.hideLoading()
          } else {
            uni.showToast({
              'icon': 'error',
              'title': res.msg
            })
          }
      } else {
        uni.showToast({ icon: 'error', title: '出现错误' })
      }
    },
  })
}
</script>

<style lang="scss" scoped>
.page-info {
  padding-bottom: 80rpx;
}
.reply-bar {
  display: flex;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20rpx;
  justify-content: space-around;
  align-items: center;
  height: 50rpx;
  border-top: 1rpx solid #c8c8c8;
  background-color: #fff;

  .btn {
    text-align: center;
    height: 60rpx;
  }
}

.mic-bar {
  height: 300rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20rpx;

  .mic-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 100%;
    height: 150rpx;
    width: 150rpx;
    background-color: #177cb0;
  }
  
}
.row{
    display: flex;
    flex-direction: row;
    width: 100%;
    justify-content: center;
    align-items: center;
      .sendButton{
        width: 150rpx;
        height: 50rpx;
        font-size: 30rpx;
        border-radius: 10rpx;
        margin: 10rpx;
        padding: 5rpx;
        text-align: center;
        color:#fff;
        border: #057748 1rpx solid;
        background-color: #12b089;
        }   
  }


    .wave {
			position: relative;
		  font-size: 28px;
		}

		.wave .circle {
		    position: absolute;
		    border-radius: 50%;
		    opacity: 0;
        width: 300rpx;
        height: 300rpx;
		}

		.wave.ripple .circle {
		    width: 200%;
    		height: 200%;
		    border: 3px solid #fff;
		}

		.wave.ripple .circle:first-child {
			animation: circle-opacity 2s infinite;
		}

		.wave.ripple .circle:nth-child(2) {
			animation: circle-opacity 2s infinite;
			animation-delay: .3s;
		}

		.wave.ripple .circle:nth-child(3) {
		 	animation: circle-opacity 2s infinite;
			animation-delay: .6s;
		}

		.wave.ripple.danger {
		    color: rgb(34, 159, 255);
		}

		.wave.ripple.danger .circle {
			border-color: rgb(34, 159, 255);
		}

		@keyframes circle-opacity{
		    from {
		        opacity: 1;
		        transform: scale(0);
		    }
		    to {
		        opacity: 0;
		        transform: scale(1);
		    }
		}
</style>
