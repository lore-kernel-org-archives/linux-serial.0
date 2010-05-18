From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
Date: Tue, 18 May 2010 12:52:13 +0900
Message-ID: <4BF20EED.5040306@samsung.com>
References: <4BF13ABA.3090504@samsung.com>
 <20100518024820.GK27571@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:65098 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab0ERDwP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 May 2010 23:52:15 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L2L00IVQK317S@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 18 May 2010 12:52:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L2L003ITK31J9@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 18 May 2010 12:52:13 +0900 (KST)
In-reply-to: <20100518024820.GK27571@trinity.fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com

On 5/18/2010 11:48 AM, Ben Dooks wrote:
> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
>> Thd dev_name and driver_name should be switched each other.
> 
> Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
>  
> Please provide some information about what problem that this is fixing
> and the impact on any existing systems.
> 

The serial device nodes are created to s3c2410_serial* on android 
platform instead of ttySAC*.
