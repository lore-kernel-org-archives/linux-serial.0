From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] serial: tegra: Fix compilation error
Date: Wed, 23 Jan 2013 09:13:23 -0700
Message-ID: <51000C23.2040002@wwwdotorg.org>
References: <1358925733-20206-1-git-send-email-vbyravarasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35039 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab3AWQN2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 11:13:28 -0500
In-Reply-To: <1358925733-20206-1-git-send-email-vbyravarasu@nvidia.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Venu Byravarasu <vbyravarasu@nvidia.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

On 01/23/2013 12:22 AM, Venu Byravarasu wrote:
> Fix compilation error, by adding the correct header file
> for Tegra clocks.

Uggh. I guess this driver did introduce new users of the Tegra reset
control APIs, which didn't get converted by the Tegra clock patches
since they went through a different tree:-(

Reviewed-by: Stephen Warren <swarren@nvidia.com>
