From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
Date: Mon, 20 May 2019 17:07:51 +0200
Message-ID: <c728b454-1aa5-da93-8ed7-f6e4ad75fc4a@linaro.org>
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
 <20190520145110.7BDAE21721@mail.kernel.org>
 <254704a2-ee20-30cd-8362-6e1bd23ec090@linaro.org>
 <f0c89b84-7c3d-596d-06e1-cb5172e62970@linaro.org>
 <20190520150320.5DBC520856@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520150320.5DBC520856@mail.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, agross@kernel.org, david.brown@linaro.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, agsumit@qti.qualcomm.com
List-Id: linux-serial@vger.kernel.org

On 5/20/19 17:03, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2019-05-20 07:58:54)
>> On 5/20/19 16:56, Jorge Ramirez wrote:
>>>
>>> yeah, semantically confusing msm_reset_dm_count is what really matters:
>>> it tells the hardware to only take n bytes (in this case only one) so
>>> the others will be ignored
>>
>> um after I said this, maybe iowrite32_rep should only be applied to
>> uartdm ... what do you think?
>>
> 
> Probably. The uartdm hardware typically required words everywhere while
> the pre-dm hardware didn't. It's an if condition so it should be OK.
> 
> It may be time to remove non-uartdm support from this driver
> all-together. From what I recall the only devices that are upstream are
> the uartdm ones, so it may be easier to just remove the legacy stuff
> that nobody has tested in many years.
> 
> 

should this be merged before removing the non-uartdm support or after?

I also have some other changes - in particular with respect to the usage
of fifosize which according to the documentation is in words not in bytes.
