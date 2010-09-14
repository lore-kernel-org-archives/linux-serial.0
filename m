From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: max3107: Fix memory leaks when returning on
 error
Date: Tue, 14 Sep 2010 14:45:28 +0100
Message-ID: <20100914144528.77ee7a6f@linux.intel.com>
References: <1284394091.2055.5.camel@cowboy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48905 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab0INOaP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Sep 2010 10:30:15 -0400
In-Reply-To: <1284394091.2055.5.camel@cowboy>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dave@gnu.org
Cc: jianwei.yang@intel.com, gregkh@suse.de, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, 13 Sep 2010 12:08:11 -0400
Davidlohr Bueso <dave@gnu.org> wrote:

> [PATCH] serial: max3107: Fix memory leaks in max3107_probe() when
> returning on error.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Acked-by: Alan Cox <alan@linux.intel.com>
