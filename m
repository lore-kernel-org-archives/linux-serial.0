From: Greg KH <gregkh@linuxfoundation.org>
Subject: TTY/serial tree now closed for 3.9
Date: Fri, 8 Feb 2013 16:04:08 -0800
Message-ID: <20130209000408.GB29346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi all,

With the release of the 3.8-rc7 kernel, I think it's time to close the
TTY/serial tree for new features / cleanups for 3.9.  So I'm closing my
tree, and will only be applying obvious bugfixes or regressions to it
until 3.9-rc1 comes out.

You can keep sending me patches for the tree that don't fit the "bugfix"
category, but note that I'll be storing them away to wait for 3.9-rc1
comes out, which might be a few weeks, so please be patient.

The TTY tree right now contains 120 patches, and the diffstat
summary is:
	 254 files changed, 6720 insertions(+), 2528 deletions(-)

thanks,

greg k-h
