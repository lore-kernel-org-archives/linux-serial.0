From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: scheduling work from receive_buf
Date: Wed, 18 May 2011 16:08:42 +0100
Message-ID: <20110518160842.4b8d855c@lxorguk.ukuu.org.uk>
References: <BANLkTiniE1zcvW0CPJF3KRJ8XV03fKwNiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49710 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933151Ab1ERPHJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 May 2011 11:07:09 -0400
In-Reply-To: <BANLkTiniE1zcvW0CPJF3KRJ8XV03fKwNiw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-serial@vger.kernel.org

On Tue, 17 May 2011 20:50:09 +0530
Pavan Savoy <pavan_savoy@sify.com> wrote:

> currently in my line discipline driver - I've implemented a
> receive_buf function inside which upon receiving a particular byte of
> data, I need to
> send a bunch of data and wait for its reception (which happens to
> accumulate in receive_buf).
> 
> for this I implemented a work struct which I schedule into the default
> work queue by doing a schedule_work inside my receive_buf function
> when I receive such byte.
> However I can't seem to do a wait_for_completion inside my work
> handler. This completion is completed upon reception inside the
> receive_buf function.
> 
> wait_for_completion inside the worker thread doesn't seem to allow the
> receive_buf to be called.
> Please suggest how best I can implement something like this ?

I think by not waiting in the first place. Personally I would write that
kind of code as a state machine and instead of blocking for stuff just
trigger actions as states are reached.

