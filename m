From: gpramod@codeaurora.org
Subject: Re: [PATCH 1/2] tty: serial: msm: Add mask value for UART_DM
 registers
Date: Wed, 8 Apr 2015 13:26:34 -0000
Message-ID: <16668184c5a5bb5edf6cfd6659a8d9b8.squirrel@www.codeaurora.org>
References: <1428498794-20833-1-git-send-email-gpramod@codeaurora.org>
    <55252B9E.4070403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55252B9E.4070403@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

>
>
> On 08/04/15 14:13, Pramod Gurav wrote:
>> There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
>> it only for UART core.
>>
>> Signed-off-by: Pramod Gurav<gpramod@codeaurora.org>
>> --
>>
>> Changes since last version:
>>   - Added new macro fo UART_DM_MR1_AUTO_RFR_LEVEL1 instead of modifying
>> existing.
>>   - Added a new macro for IPR register as it is also different in
>> UART_DM
>>   - Changed subject line
>>
>> ---
>
> Change log should come after ---, else it will end up in git log.

Oops. Thanks for pointing. Will resend. :)
>
>
> --srini
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
