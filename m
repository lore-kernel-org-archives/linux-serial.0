From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 24/31] serial: tegra: use reset framework
Date: Tue, 19 Nov 2013 15:24:07 -0800
Message-ID: <20131119232407.GC24947@kroah.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-25-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42576 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab3KSXXq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Nov 2013 18:23:46 -0500
Content-Disposition: inline
In-Reply-To: <1384548866-13141-25-git-send-email-swarren@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com, pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Fri, Nov 15, 2013 at 01:54:19PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
> 
> Cc: treding@nvidia.com
> Cc: pdeschrijver@nvidia.com
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
