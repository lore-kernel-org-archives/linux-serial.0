From: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Thu, 20 Nov 2008 16:20:54 +0100
Message-ID: <20081120152054.GO24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de> <20081120141345.GA2410@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cursor.subgra.de ([78.46.252.50]:38197 "EHLO cursor.subgra.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbYKTPmq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 10:42:46 -0500
Content-Disposition: inline
In-Reply-To: <20081120141345.GA2410@yoda.jdub.homelinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>

Hi Josh,

>What does 'NWP' stand for, and how is it different from a regular serial
>port?  Also, what platforms can this device be found on currently?
>
>Some of that should be included in the changelog, but I'm curious as well
>too.

NWP stands for network processor and it is part of the QPACE - Quantum
Chromodynamics Parallel Computing on the Cell Broadband Engine
project [1]. The implementation is a lightweight uart implementation
with the focus to consume as little resources as possible and it is
connected to a DCR bus.

 Ben
