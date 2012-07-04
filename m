From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/2] Split off bitblit operations for fblog
Date: Wed,  4 Jul 2012 23:48:32 +0200
Message-ID: <1341438514-1786-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, David Herrmann <dh.herrmann@googlemail.com>
List-Id: linux-serial@vger.kernel.org

Hi

This is a patchset that moves update_attr() and bit_putcs() into a separate
source file and makes both files not depend on any vc_* or fbcon_* structures
and code. That is, we can now safely use both in the fblog patchset that I sent
last month. Otherwise, we would need to copy both functionalities.

The rotation helpers have very similar functions which do the same but with
rotation in mind. I didn't find an efficient way to merge them so I decided to
leave them as they are. Furthermore, I am not using them so there is no need to
split them off.

I actually don't know who is taking patches for fblog and which trees they are
going through, but if you think I should include the patches in the fblog
patchset instead, I will do so. Otherwise, it would be nice if they could be
applied separately. The second fblog patchset will follow tomorrow.

I also tested both patches on my machine and couldn't notice any performance
breakdowns, but it would be nice if someone else could test them, too. The
second patch mentions this shortly, regarding the additional kmalloc().

Regards
David

David Herrmann (2):
  fbcon: move update_attr() into separate source file
  fbcon: move bit_putcs() into separate source file

 drivers/video/console/Makefile  |   3 +-
 drivers/video/console/bitblit.c | 149 +++-------------------------------
 drivers/video/console/fbcon.h   |   5 +-
 drivers/video/console/fbdraw.c  | 171 ++++++++++++++++++++++++++++++++++++++++
 drivers/video/console/fbdraw.h  |  30 +++++++
 5 files changed, 215 insertions(+), 143 deletions(-)
 create mode 100644 drivers/video/console/fbdraw.c
 create mode 100644 drivers/video/console/fbdraw.h

-- 
1.7.11.1
