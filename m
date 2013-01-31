From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3] serial: tegra: Convert to devm_ioremap_resource()
Date: Thu, 31 Jan 2013 10:00:08 -0700
Message-ID: <510AA318.5060208@wwwdotorg.org>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org> <1359627939-2685-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50596 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab3AaRAM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 12:00:12 -0500
In-Reply-To: <1359627939-2685-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org

On 01/31/2013 03:25 AM, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.

Presumably though that function isn't yet available in the tree that
this new serial driver was merged through is it?
