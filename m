From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Add runtime PM and system sleep support
Date: Thu, 25 Aug 2016 10:10:51 +0530
Message-ID: <CANYu_0sRYPh07=dR0=sBCjw+mtkUTQVW1Pq1a94e8Cf9Z57-DA@mail.gmail.com>
References: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org> <CAPBZ5Qf6T1=1+Xc_hea5zbPSs7th7F7pSLg+5dqmiPBnb6m8=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPBZ5Qf6T1=1+Xc_hea5zbPSs7th7F7pSLg+5dqmiPBnb6m8=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 25 August 2016 at 10:05, Andy Gross <andy.gross@linaro.org> wrote:
> On 17 June 2016 at 05:16, Pramod Gurav <pramod.gurav@linaro.org> wrote:
>

<snip>

>> +       if (msm_port->is_uartdm) {
>> +               ret = clk_enable(msm_port->pclk);
>
> Ditto here.

Thanks Andy, will include these two changes in v2.
>
>> +               if (ret)
