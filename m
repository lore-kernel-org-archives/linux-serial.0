From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/4] Serial: UART driver changes for Cavium OCTEON.
Date: Wed, 3 Dec 2008 15:46:58 +0000
Message-ID: <20081203154658.7f54144c@lxorguk.ukuu.org.uk>
References: <4934774E.6080805@caviumnetworks.com>
	<1228175368-5536-4-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52399 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbYLCPrJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Dec 2008 10:47:09 -0500
In-Reply-To: <1228175368-5536-4-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

On Mon,  1 Dec 2008 15:49:28 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> Cavium UART implementation is not covered by existing uart_configS.
> Define a new uart_config (PORT_OCTEON) which is specified by OCTEON
> platform device registration code.

All 4 queued
