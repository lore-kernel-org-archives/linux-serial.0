From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] serial: pxa: brief description
Date: Sat, 30 Jul 2011 12:01:25 +0200
Message-ID: <1312020086-26328-1-git-send-email-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I had a problem with a pxa270-based custom board when using the UART on
high speed (921.6 kbit/s).
The symptom was that the whole system just hangs sporadically.

After this work around was implemented the system seems to behave good.

In fact, I don't really see why the system should hang since there is a 
max counter, so the loop cannot run forever.

The patch is tested on kernel version 2.6.32, but the driver is allmost
the same.

Please take a look.
Feedback is very much appreciated
