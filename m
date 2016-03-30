From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Wed, 30 Mar 2016 12:01:56 -0500
Message-ID: <56FC0684.1050109@codeaurora.org>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
 <1457678154-2272-1-git-send-email-cov@codeaurora.org>
 <56E7DF1F.7010006@arm.com> <56FBC6EA.6080909@codeaurora.org>
 <20160330165551.GB23817@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330165551.GB23817@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christopher Covington <cov@codeaurora.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote:
> If this isn't a bug fix or regression fix, it's not ok for 4.6-final, it
> will have to wait for 4.7-rc1.

It fixes a problem on our platform (QDF2432).  Without this patch, we 
can't use the PL011 at all.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
