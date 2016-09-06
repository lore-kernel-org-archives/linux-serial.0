From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH 5/7] serial: 8250_fintek: Add F81216 Support
Date: Tue, 6 Sep 2016 10:04:26 +0800
Message-ID: <d961cfe4-4086-b3a0-a0cf-2a42a8290290@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1472701196-14795-6-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAPybu_19AgXA+Thc6sd-Zp-707P+u47xzJpcnFuJGTa9YvWYbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_19AgXA+Thc6sd-Zp-707P+u47xzJpcnFuJGTa9YvWYbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

Ricardo Ribalda Delgado 於 2016/9/1 下午 07:22 寫道:
>>
>>         memcpy(pdata, &probe_data, sizeof(probe_data));
>> -       uart->port.rs485_config = fintek_8250_rs485_config;
>
> Maybe just:
>
>
> if (pdata->id != CHIP_ID_F81216)
>    uart->port.rs485_config = fintek_8250_rs485_config;
>
>
> Instead of the whole function
>
>>         uart->port.private_data = pdata;
>> +       fintek_8250_set_rs485_handler(uart);
>>
>>         return 0;
>>  }

Your comments is good for this patch. But we'll still try to add more 
SuperIO with this. So we'll separate it as a function to control
individually.

-- 
With Best Regards,
Peter Hong
