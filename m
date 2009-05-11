From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] Char/serial: refactor ASYNC_ flags
Date: Mon, 11 May 2009 18:57:27 +0100
Message-ID: <20090511185727.2a5bd4cb@lxorguk.ukuu.org.uk>
References: <1242049860-29501-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44688 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753184AbZEKR5y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 May 2009 13:57:54 -0400
In-Reply-To: <1242049860-29501-1-git-send-email-jirislaby@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Ferenc Wagner <wferi@niif.hu>, Paul Fulghum <paulkf@microgate.com>

On Mon, 11 May 2009 15:50:58 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> Define ASYNCB_* flags which are bit numbers of the ASYNC_* flags.
> This is useful for {test,set,clear}_bit.
> 
> Also convert each ASYNC_% to be (1 << ASYNCB_%) and define masks
> with the macros, not constants.

Series all applied
