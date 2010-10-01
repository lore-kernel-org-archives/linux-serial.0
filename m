From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 8/8] altera_uart: Don't use plain integer as NULL
	pointer
Date: Fri, 1 Oct 2010 15:50:33 +0200
Message-ID: <20101001135033.GD30954@distanz.ch>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru> <20101001132313.GH25897@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:44517 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635Ab0JANue (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:50:34 -0400
Content-Disposition: inline
In-Reply-To: <20101001132313.GH25897@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 2010-10-01 at 15:23:13 +0200, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> Fixes sparse warning.
> 
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
