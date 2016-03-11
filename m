From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v2] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Sat, 12 Mar 2016 06:38:44 +0700
Message-ID: <34828481-F042-423A-BCE9-824AAFFA1A13@codeaurora.org>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org> <1457678154-2272-1-git-send-email-cov@codeaurora.org> <56E2DDF6.2000107@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E2DDF6.2000107@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Andre Przywara <andre.przywara@arm.com>, Dave Martin <dave.martin@arm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org



On March 11, 2016 10:02:14 PM GMT+07:00, Peter Hurley <peter@hurleysoftware.com> wrote:
>Hi Christopher,
>
>On 03/10/2016 10:35 PM, Christopher Covington wrote:
>> Version 2 of the Server Base System Architecture (SBSAv2) describes
>the
>> Generic UART registers as 32 bits wide. At least one implementation,
>found
>> on the Qualcomm Technologies QDF2432, only supports 32 bit accesses.
>> SBSAv3, which describes supported access sizes in greater detail,
>> explicitly requires support for both 16 and 32 bit accesses to all
>> registers (and 8 bit accesses to some but not all). Therefore, for
>broad
>> compatibility, simply use 32 bit accessors for the SBSA UART.
>
>So this eliminates the need to configure SBSA port via ACPI, correct?
>Thus, Aleksey can drop his "serial: pl011: use SPCR to setup 32-bit
>access"?

Yes.

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

Sent from my Snapdragon powered Android device with K-9 Mail. Please excuse my brevity.
