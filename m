From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/6] Blackfin Serial Driver: Add a debug function to
 serial driver.
Date: Tue, 14 Oct 2008 14:27:01 +0100
Message-ID: <20081014142701.72090868@lxorguk.ukuu.org.uk>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org>
	<1223891185-13924-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34330 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbYJNN1X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2008 09:27:23 -0400
In-Reply-To: <1223891185-13924-3-git-send-email-cooloney@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Graf Yang <graf.yang@analog.com>, Bryan Wu <cooloney@kernel.org>

> -		cpu_relax();
> +		barrier();
> +

Seems to be an odd unrelated change ?

