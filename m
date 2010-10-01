From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/8] altera_uart: Make it possible to use Altera UART
 and 8250 ports together
Date: Fri, 1 Oct 2010 13:41:38 +0100
Message-ID: <20101001134138.5ea2fb55@linux.intel.com>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
	<20101001132207.GE25897@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61689 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab0JANaf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:30:35 -0400
In-Reply-To: <20101001132207.GE25897@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 1 Oct 2010 17:22:07 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> This fixes tty name and major number conflicts. The major number
> 204 is used across many platform-specific serial drivers, so we
> use that.

204 is allocated in small chunks to specific low volume devices so you
need a proper minor allocation

At this point that would be 204,213 for whatever tiny range you need.

Please send me a patch for devices.txt and update accordingly,
otherwise no objections.

Alan
