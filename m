From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Tue, 18 Jun 2002 09:05:20 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <008001c216c8$d0bfdba0$294b82ce@connecttech.com>
References: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE> <200206171900.03955.rwhite@pobox.com>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: rwhite@pobox.com, Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 'Russell King' <rmk@arm.linux.org.uk>, 'Theodore Tso' <tytso@mit.edu>

From: "Robert White" <rwhite@pobox.com>
> should you use your greater-access to the code and user base, you would
find
> a single case where it breaks, invalidates, or confuses a single person or
> program on the planet.

I can see one easy case: protocol has frame size of N. VMIN is set to
say 3 * N. read() supplies a buffer of N. The purpose being that the
first read will block until 3 frames are ready to process, then return
the first one. Your patch would break that.

Having said that, I don't know of any instances where the above is
employed. I'd say your patch is worthwhile.

..Stu


