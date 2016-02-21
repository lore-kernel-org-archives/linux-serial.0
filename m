From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] serial: samsung: fix the inconsistency in spinlock
Date: Sun, 21 Feb 2016 10:30:02 +0900
Message-ID: <CAJKOXPf7R0_qxH6zNm0YK=AZVafeLJe9Yz4WP09JEnK=C8v0dw@mail.gmail.com>
References: <1455817202-3005-1-git-send-email-linux.amoon@gmail.com>
	<56C603E9.9050307@hurleysoftware.com>
	<CANAwSgQuo_V_6J4C6MgdiDFeTTGaTPzoONSUKXwcanCpCWtZSg@mail.gmail.com>
	<CAJKOXPdE4LB=xfkZb_rnFGVjkh4D9XvrdUhqPAJwfh2mUr_tHQ@mail.gmail.com>
	<CANAwSgQ2GeLaWcW5zRWPcNZ1Pk-Yq-NY4z5yqo6DXyyMRC2y3g@mail.gmail.com>
	<56C6C7E3.4060200@samsung.com>
	<CANAwSgR0fcD0fd-41fkV3Lzh-aMJovsmKL6YMWfstRvTD55_fw@mail.gmail.com>
	<56C6D1E3.1060202@samsung.com>
	<CANAwSgQSmRnyW5BwMpttFsMzitAzVbK7ww=ySctLmG82K4Wi=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANAwSgQSmRnyW5BwMpttFsMzitAzVbK7ww=ySctLmG82K4Wi=A@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

>>> In my next patch I have tried to remove the spin_unlock/spin_lock over
>>> uart_write_wakeup(port);
>>
>> Which may create lockups. Previously there was no port locking around
>> uart_write_wakeup. Now there will be. You are effectively adding locking
>> over uart_write_wakeup().
>> Again, we are back at the Peter's message - just check the damned lockups...
>>
>> BR,
>> Krzysztof
>>
>> BR
>>
>
> Lets drop this patch. I have send new one earlier.
> https://lkml.org/lkml/2016/2/19/2
>
> If you have any comment on that.
> Sorry for the confusion.

I was commenting your future patch about dropping spinlocks.
Apparently there is huge misunderstanding here...

Best regards,
Krzysztof
