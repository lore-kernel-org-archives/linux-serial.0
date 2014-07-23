From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm: Make of_device_id array const
Date: Wed, 23 Jul 2014 16:26:35 -0700
Message-ID: <53D044AB.4060009@codeaurora.org>
References: <1406111186-16627-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1406111186-16627-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal21@gmail.com>
Cc: davidb@codeaurora.org, gregkh@linuxfoundation.org, dwalker@fifo99.com, bryanh@codeaurora.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kiran.padwal@smartplayin.com
List-Id: linux-serial@vger.kernel.org

On 07/23/14 03:26, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const.
>
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
