From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] [v2] tty: amba-pl011: fix earlycon register offsets
Date: Tue, 5 Jan 2016 20:46:11 -0600
Message-ID: <568C7FF3.20804@codeaurora.org>
References: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
 <20160106024338.GA20633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160106024338.GA20633@kroah.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.com, jun.nie@linaro.org, shijie.huang@arm.com, peter@hurleysoftware.com, andrew.jackson@arm.com, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote:
>> >Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> >Tested-by: Huang Shijie<shijie.huang@arm.com>
>> >Signed-off-by: Timur Tabi<timur@codeaurora.org>
>> >---
>> >  drivers/tty/serial/amba-pl011.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
> What changed in v2?

I fixed a typo with a macro name (UART01x_FR_BUSY instead of 
UART011_FR_BUSY).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
