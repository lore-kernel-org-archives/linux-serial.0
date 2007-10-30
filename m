From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/16] CRIS architecture: Correct compile errors
Date: Tue, 30 Oct 2007 15:13:56 -0700
Message-ID: <20071030151356.3eaa197b.akpm@linux-foundation.org>
References: <20071030092636.GC11960@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45781 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755268AbXJ3WOT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Oct 2007 18:14:19 -0400
In-Reply-To: <20071030092636.GC11960@axis.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: mikael.starvik@axis.com, jesper.nilsson@axis.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-serial@vger.kernel.org, dwmw2@infradead.org

On Tue, 30 Oct 2007 10:26:36 +0100
Jesper Nilsson <jesper.nilsson@axis.com> wrote:

> The following patchset makes it possible to compile for the
> CRIS architecture, at least when applied to the 2.6.23 kernel.
> 
> Most patches are trivial, but some are a bit more complex,
> like the changes to the CRIS ethernet and serial drivers.
> 
> I've separated the changes out to logical components to ease
> reviewing. Please send any comments or questions to me and
> Mikael Starvik.

Please carefully choose good titles for your patches.

Please certainly do not send sixteen patches all with the same title.

For these patches I have invented titles for you.

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt goes into
details.
