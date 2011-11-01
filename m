From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2] pch_uart: Fix hw-flow control issue
Date: Tue, 1 Nov 2011 12:55:03 +0000
Message-ID: <20111101125503.233847d1@bob.linux.org.uk>
References: <1319697919-5623-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12180 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189Ab1KAMoY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Nov 2011 08:44:24 -0400
In-Reply-To: <1319697919-5623-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com

On Thu, 27 Oct 2011 15:45:18 +0900
Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com> wrote:

> Using hardware flow control,
> currently, register of the control-bit(AFE) is not set.
> This patch fixes the issue.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>

Acked-by: Alan Cox <alan@linux.intel.com>
