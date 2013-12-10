From: Karl Dahlke <eklhad@comcast.net>
Subject: Bug in tty cooked mode kernel 3.12.3
Date: Mon, 09 Dec 2013 19:12:04 -0500
Message-ID: <20131109191204.eklhad@comcast.net>
References: <20131107184607.eklhad@comcast.net> <1386630367-4658-1-git-send-email-peter@hurleysoftware.com>
Reply-To: Karl Dahlke <eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:57885
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab3LJAN3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 19:13:29 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter@hurleysoftware.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org

> Thanks for the report, Karl.
> 
> Please test the patch below (requires
> commit 39434abd942c8e4b9c14c06a03b3245beaf8467f,
> 'n_tty: Fix missing newline echo').
> This should fix the 'newline output after the new prompt' problem.

Hey hey - you did it!
I did my console switch, which *always* revealed the bug,
and it is not there any more.
I've also spent a couple hours in cooked mode programs, like my editor,
and the lines are all correct.
I'll keep at it for a few days, but for now I'm going to say it's fixed.
Please push this into the next release, and perhaps backport
if possible; for those of us in cooked line mode
it was really an inconvenient bug.
Finally, my complements to you.
I read the code in n_tty.c and I don't understand any of it.
It's way beyond me.
Nice job, and thank you.


Karl Dahlke
