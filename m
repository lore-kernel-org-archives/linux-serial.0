From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: fix the mismatched IRQ mode
Date: Tue, 28 Jun 2016 08:51:38 +0800
Message-ID: <430c447a-bf8f-6268-9d55-e29ada539ea2@gmail.com>
References: <1464314571-15429-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAPybu_2BM-Nm02Y6xv-jg0MMaNGuEgmG6=5S3OO3KuwDUPmHMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_2BM-Nm02Y6xv-jg0MMaNGuEgmG6=5S3OO3KuwDUPmHMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Alan Cox <alan@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo & Greg,

Ricardo Ribalda Delgado =E6=96=BC 2016/6/27 =E4=B8=8B=E5=8D=88 06:25 =E5=
=AF=AB=E9=81=93:
> Hi Peter,. Hi Greg
> On Fri, May 27, 2016 at 4:02 AM, Ji-Ze Hong (Peter Hong)
>> +       struct irq_data *irq_data =3D irq_get_irq_data(uart->port.ir=
q);
>> +       bool level_mode =3D irqd_is_level_type(irq_data);
>
> I see a potential problem with this patch:
>
> If irq_get_irq_data fails, it will return NULL, resulting on a
> segmentation fault on irqd_is_level_type:
>
> #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_acce=
ssors)
>
>
> I believe that we need to add error checks here

I'll try to send a patch to add more checks.

>> -       return 0;
>> +       return fintek_8250_set_irq_mode(pdata, level_mode);
>
> Also why do not call irq_get_irq_data() and  irqd_is_level_type()
> before return? There is no need to do that work if the probe
> determines that it is not a fintek chip.
>

Also determine the IRQ mode when found a fintek chip.

Thanks to point out the potential issue.
--=20
With Best Regards,
Peter Hung
