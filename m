From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
Date: Mon, 10 Jun 2019 21:11:21 +0200
Message-ID: <e656ddd3-f327-818d-3688-f24fddcb52c5@linaro.org>
References: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
 <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org, David Brown <david.brown@linaro.org>, jslaby@suse.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khasim.mohammed@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 6/10/19 19:53, Rob Clark wrote:
> On Mon, Jun 10, 2019 at 10:23 AM Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
>> The function msm_wait_for_xmitr can be taken with interrupts
>> disabled. In order to avoid a potential system lockup - demonstrated
>> under stress testing conditions on SoC QCS404/5 - make sure we wait
>> for a bounded amount of time.
>>
>> Tested on SoC QCS404.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 
> I had observed that heavy UART traffic would lockup the system (on
> sdm845, but I guess same serial driver)?
> 
> But a comment from the peanut gallary:  wouldn't this fix lead to TX
> corruption, ie. writing more into TX fifo before hw is ready?  I
> haven't looked closely at the driver, but a way to wait without irqs
> disabled would seem nicer..
> 
> BR,
> -R
> 

I think sdm845 uses a different driver (qcom_geni_serial.c) but yes in
any case we need to determine the sequence leading to the lockup. In our
internal releases we are adding additional debug information to try to
capture this info.

But also I dont think this means that the safety net should not be used

btw, do you think that perhaps we should add a WARN_ONCE() on timeout?.
