From: Stephen Hemminger <shemminger@osdl.org>
Subject: Someting's busted with serial in 2.6.11 latest
Date: Wed, 9 Mar 2005 15:50:49 -0800
Message-ID: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some checkin since 2.6.11 has caused the serial driver to
drop characters.  Console output is chopped and messages are garbled.
Even the shell prompt gets truncated.
