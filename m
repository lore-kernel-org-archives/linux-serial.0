From: William Hubbs <w.d.hubbs@gmail.com>
Subject: request for assistance:  accessing ttys from kernel space
Date: Mon, 25 Jan 2010 20:02:03 -0600
Message-ID: <20100126020203.GA23551@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753266Ab0AZCCN@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@suse.de, Samuel Thibault <samuel.thibault@ens-lyon.org>, Chris Brannon <cmbrannon79@gmail.com>, Kirk Reiser <kirk@reisers.ca>
List-Id: linux-serial@vger.kernel.org

Hello.

I am the lead developer for gentoo linux's accessibility team[1], and I
am on the development team for the speakup screen reader [2].

I received these addresses from Samuel, and Chris and Kirk are the other
developers on the speakup team.

Currently, speakup is using direct hardware access to communicate with
serial ports.  Doing so, however, has limitations since we are hard
coding port addresses and IRQ numbers.  For example, we have a user
right now who is wanting to use a PCI Express serial card for his
synthesizer, but the port and IRQ are not standard, so speakup is unable
to use it.  He says that the kernel does recognize the card however.

What I would like to discuss is how we can access ttys from kernel
space.  If we could do this, it would definitely make things much easier
for us in speakup.

For reference, our git repository is at
http://linux-speakup.org/speakup.git.  We are looking to write another
.c file similar to serialio.c but using ttys or some other way to access
the serial ports which works better than hard coading ports and IRQs.

We found another example of attempting this on the web [3], but this
doesn't work any longer according to the thread.

We need to be able to access the ttys as early as possible in the boot
sequence.  Any help, suggestions, or guidance you could give us would be
greatly appreciated.

Thanks much,

William

[1] http://www.gentoo.org/proj/en/desktop/accessibility
[2] http://linux-speakup.org
[3]
http://www.linuxquestions.org/questions/programming-9/accessing-tty-in-kernel-space-596538/
