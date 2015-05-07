From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 3/3] tty: serial: msm: replaces (1 << x) with BIT(x)
 macro
Date: Thu, 07 May 2015 16:37:24 -0700
Message-ID: <554BF734.9020201@codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org> <1428668396-6955-3-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-3-git-send-email-gpramod@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/10/15 05:19, Pramod Gurav wrote:
> Replaces (1 << x) with BIT(x) macro
>
> Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
