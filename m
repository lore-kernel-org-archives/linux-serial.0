From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Date: Fri, 11 Apr 2008 12:08:48 -0500
Message-ID: <47FF9B20.70207@freescale.com>
References: <20080311171045.GB4684@localhost.localdomain>	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org> <20080411160654.GA25506@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:65254 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235AbYDKRJU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Apr 2008 13:09:20 -0400
In-Reply-To: <20080411160654.GA25506@polina.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, linux-serial@vger.kernel.org, netdev@vger.kernel.org

Anton Vorontsov wrote:

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC] UCC nodes cleanup
> 
> - get rid of `model = "UCC"' in the ucc nodes
>   It isn't used anywhere, so remove it. If we'll ever need something
>   like this, we'll use compatible property instead.
> - replace last occurrences of device-id with cell-index.
>   Drivers are modified for backward compatibility's sake.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
