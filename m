From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] tty: erase buffers when the kernel is done with it.
Date: Thu,  4 Oct 2018 11:06:12 -0700
Message-ID: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build, gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

azlig and Milan Broz reported that when the tty layer is done with a
buffer, the data can hang around in it for a very long time.  That
sometimes can "leak" to userspace under some conditions.

Because of this, just zero out the data after the tty layer is finished
with it, for buffers that we "think" should be zeroed out.

v2 - addressed some review comments on the 2/2 patch.

Greg Kroah-Hartman (1):
  tty: wipe buffer if not echoing data

Linus Torvalds (1):
  tty: wipe buffer.

 drivers/tty/n_tty.c      | 20 +++++++++++++++++---
 drivers/tty/tty_buffer.c |  6 +++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.19.0
