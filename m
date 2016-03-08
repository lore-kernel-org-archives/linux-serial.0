From: Mark Langsdorf <mlangsdo@redhat.com>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Tue, 8 Mar 2016 08:51:53 -0600
Message-ID: <56DEE709.7060907@redhat.com>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Andre Przywara <andre.przywara@arm.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <christopher.covington@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 03/07/2016 11:43 PM, Christopher Covington wrote:
> From: Christopher Covington <christopher.covington@linaro.org>
>
> Version 2 of the Server Base System Architecture (SBSA) describes the
> Generic UART registers as 32 bits wide. At least one implementation, found
> of the Qualcomm Technologies QDF2432, only supports 32 bit accesses. While
> other implementations may also support smaller sized accesses, simply use
> 32 bit accesses all the time for the SBSA UART for simple, broad,
> compatibility.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---

I can boot the v4.5-rc7 on my QDF2432 platform with this patch,
and could not otherwise.

Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
