From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add support for a no-name 4 ports multiserial card
Date: Fri, 6 Jun 2008 16:04:28 +0100
Message-ID: <20080606160428.151e7ece@core>
References: <1212736393-6837-1-git-send-email-catab@embedromix.ro>
	<20080606111400.1eefc4fd@core>
	<484930A3.1020103@embedromix.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53404 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757969AbYFFPUv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jun 2008 11:20:51 -0400
In-Reply-To: <484930A3.1020103@embedromix.ro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Catalin(ux) M BOIE" <catab@embedromix.ro>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, akpm@osdl.org

> > Either the hex or a local and obviously unknown name like ID_UNKNOWN_1
> 
> Do you agree to use ID_UNKNOWN_0x1584?

Excellent idea


> And here pbn_plx_unknown_0x1584?

Ditto

Acked-by: Alan Cox <alan@redhat.com>

Alan
