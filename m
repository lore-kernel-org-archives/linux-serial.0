From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Wed, 30 Mar 2016 11:01:59 -0700
Message-ID: <20160330180159.GA24988@kroah.com>
References: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
 <1457678154-2272-1-git-send-email-cov@codeaurora.org>
 <56E7DF1F.7010006@arm.com>
 <56FBC6EA.6080909@codeaurora.org>
 <20160330165551.GB23817@kroah.com>
 <56FC0684.1050109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FC0684.1050109@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>, Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 30, 2016 at 12:01:56PM -0500, Timur Tabi wrote:
> Greg Kroah-Hartman wrote:
> >If this isn't a bug fix or regression fix, it's not ok for 4.6-final, it
> >will have to wait for 4.7-rc1.
> 
> It fixes a problem on our platform (QDF2432).  Without this patch, we can't
> use the PL011 at all.

Did it ever work before?  Or is this new functionality?
