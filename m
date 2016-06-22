From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] tty: serial: msm: Don't reconfigure same baud rate
Date: Wed, 22 Jun 2016 10:59:04 +0100
Message-ID: <576A6168.1000901@linaro.org>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
 <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
 <CAP71WjyPiDK+rr6Z6=Cvp_Bjrpd2HSQ_K58ucJqJ5ZWs_4khtw@mail.gmail.com>
 <CAP71WjzCYvwiS6BhjF8V=vi20_6ekcZk73qFF5zSf=tcCV20wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP71WjzCYvwiS6BhjF8V=vi20_6ekcZk73qFF5zSf=tcCV20wQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org



On 21/06/16 10:43, Nicolas Dechesne wrote:
> On Fri, Jun 17, 2016 at 1:02 PM, Nicolas Dechesne
> <nicolas.dechesne@linaro.org> wrote:
>> <bjorn.andersson@linaro.org> wrote:
>>> msm_set_termios() is called whenever the tty is opened. Setting the=
 baud
>>> rate requires a full reset of the msm serial block, even when the r=
ate
>>> is unchanged. In the case when the same uart is used as console thi=
s
>>> reset will discard any console output data still being clocked out =
of
>>> the TX fifo.
>>>
>>> By skipping the rate-change in the case where the baud rate is unch=
anged
>>> since last request we can avoid the reset and the discarding of the
>>> data.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>>
>> Tested-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
>>
>> I no longer see this type of corruption on serial console
>>
>> [    6.325118] ALSA device =EF=BF=BD[    6.333338] Freeing unused ke=
rnel
>> memory: 572K (ffffffc000c10000 - ffffffc000c9f000)
>> [   13.800269]  remoteproc2: remote processor a20400=EF=BF=BD[  OK  =
] Started
>> Start the WCN core.
>> [ =EF=BF=BD         Starting Update UTMP about System Runlevel Chang=
es...
>
>
> oops. today i tried on APQ8064 boards , both IFC6410Plus and SD
> 600eval, and I can no longer 'type' into the serial console, I can ge=
t
> debug messages though. Reverting this change 'fixes' the problem.

Am also hitting the same issue as Nico on IFC6410 with this patch.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
