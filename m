From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY fixes for 4.7-rc6
Date: Fri, 1 Jul 2016 09:14:46 -0700
Message-ID: <20160701161446.GA29312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.7-rc6

for you to fetch changes up to 5353ed8deedee9e5acb9f896e9032158f5d998de:

  devpts: fix null pointer dereference on failed memory allocation (2016-06-26 11:39:00 -0700)

----------------------------------------------------------------
tty fixes for 4.7-rc6

Here are two tty fixes for some reported issues.  One resolves a crash
in devpts, and the other resolves a problem with the fbcon cursor blink
causing lockups.

Both have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      devpts: fix null pointer dereference on failed memory allocation

David Daney (1):
      tty: vt: Fix soft lockup in fbcon cursor blink timer.

 drivers/tty/pty.c   | 7 +++++--
 drivers/tty/vt/vt.c | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)
