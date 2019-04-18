From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
Date: Thu, 18 Apr 2019 15:09:51 +0900
Message-ID: <fa2bd516-adc1-a121-b83e-ae00a8f99d6c@socionext.com>
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
 <20190418051732.GA17053@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418051732.GA17053@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 2019/04/18 14:17, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2019 at 11:51:56AM +0900, Sugaya Taichi wrote:
>> Add Milbeaut serial control including earlycon and console.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>> Changes from v2:
>>   - Fix build warning.
> 
> No, I only need an incremental patch fixing the one sparse warning
> found, not a whole new patch as I have already merged your original
> patch, right?
> 

Sorry for my misunderstanding.
I got it.

Thanks,
Sugaya Taichi


> thanks,
> 
> greg k-h
> 
