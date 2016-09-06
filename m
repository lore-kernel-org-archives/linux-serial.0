From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH 3/7] serial: 8250_fintek: Set maximum FIFO of F81216H
Date: Tue, 6 Sep 2016 09:37:58 +0800
Message-ID: <bc53ebae-1f0a-b7ff-90b3-4dfb6278da5f@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1472701196-14795-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAPybu_1-N_+QJwUtfxHRs84Mnd=D72xnprSSjX1jqLK2AN_eyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_1-N_+QJwUtfxHRs84Mnd=D72xnprSSjX1jqLK2AN_eyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

Ricardo Ribalda Delgado 於 2016/9/1 下午 07:16 寫道:
>> +static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
>> +{
>> +       switch (pdata->pid) {
>> +       default: /* Default 16Bytes FIFO */
>> +               return;
>> +
>> +       case CHIP_ID_F81216H: /* 128Bytes FIFO */
>> +               sio_write_mask_reg(pdata, FIFO_CTRL,
>> +                                  FIFO_MODE_MASK | RXFTHR_MODE_MASK,
>> +                                  FIFO_MODE_128 | RXFTHR_MODE_4X);
>> +               break;
>> +       }
>
> I think it is more clear to have the default case as the ast one;

OK, I'll modify all default label to the last one.

>> +}
>> +
>>  static int find_base_port(struct fintek_8250 *pdata, u16 io_address,
>>                           unsigned int irq)
>
> I think that we should rename find_base_port to something else like
> probe_setup_port(),  we are not only finding the port but also setting
> it up.
>

OK, I'll modify it with next version.

-- 
With Best Regards,
Peter Hong
