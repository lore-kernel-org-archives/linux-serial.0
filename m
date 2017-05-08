From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] TTY patches for 4.12-rc1
Date: Mon, 8 May 2017 11:48:03 +0200
Message-ID: <20170508094803.GB7452@kroah.com>
References: <20170508094624.GA7452@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170508094624.GA7452@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 08, 2017 at 11:46:24AM +0200, Greg KH wrote:
> The following changes since commit 4f7d029b9bf009fbee76bb10c0c4351a1870d2f3:
> 
>   Linux 4.11-rc7 (2017-04-16 13:00:18 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.12-rc1
> 
> for you to fetch changes up to 8e1c21f486944bf92f2a981f23ee811a45f5eaff:
> 
>   serial: small Makefile reordering (2017-04-18 18:01:52 +0200)
> 
> ----------------------------------------------------------------
> TTY/Serial patches for 4.12-rc1
> 
> Here is the "big" TTY/Serial patch updates for 4.12-rc1
> 
> Not a lot of new things here, the normal number of serial driver updates
> and additions, tiny bugs fixed, and some core files split up to make
> future changes a bit easier for Nicolas's "tiny-tty" work.
> 
> All of these have been in linux-next for a while.  There will be a merge
> conflict with include/linux/serdev.h coming from the bluetooth tree
> merge, which we knew about, as we wanted some of the serdev changes to
> go in through that tree.  I'll send the expected merge result as a
> follow-on message.

And below is the ideal merge fixup as created by Stephen, and reported a
few weeks ago.  I've tested it and it works here for me.

thanks,

greg k-h

------------
Date: Thu, 13 Apr 2017 13:36:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Gustavo Padovan <gustavo@padovan.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
        List <linux-kernel@vger.kernel.org>, Sebastian Reichel
        <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Andrey Smirnov
        <andrew.smirnov@gmail.com>
Subject: linux-next: manual merge of the tty tree with the bluetooth tree

Hi Greg,

Today's linux-next merge of the tty tree got a conflict in:

  include/linux/serdev.h

between commits:

  b3f80c8f75ef ("serdev: add serdev_device_wait_until_sent")
  5659dab26f09 ("serdev: implement get/set tiocm")

from the bluetooth tree and commit:

  6fe729c4bdae ("serdev: Add serdev_device_write subroutine")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc include/linux/serdev.h
index 37395b8eb8f1,0beaff886992..000000000000
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@@ -191,10 -190,8 +195,11 @@@ int serdev_device_open(struct serdev_de
  void serdev_device_close(struct serdev_device *);
  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
  void serdev_device_set_flow_control(struct serdev_device *, bool);
 +void serdev_device_wait_until_sent(struct serdev_device *, long);
 +int serdev_device_get_tiocm(struct serdev_device *);
 +int serdev_device_set_tiocm(struct serdev_device *, int, int);
- int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
+ void serdev_device_write_wakeup(struct serdev_device *);
+ int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
  void serdev_device_write_flush(struct serdev_device *);
  int serdev_device_write_room(struct serdev_device *);
  
@@@ -231,16 -228,8 +236,17 @@@ static inline unsigned int serdev_devic
  	return 0;
  }
  static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
 +static inline void serdev_device_wait_until_sent(struct serdev_device *sdev, long timeout) {}
 +static inline int serdev_device_get_tiocm(struct serdev_device *serdev)
 +{
 +	return -ENOTSUPP;
 +}
 +static inline int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
 +{
 +	return -ENOTSUPP;
 +}
- static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
+ static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf,
+ 				      size_t count, unsigned long timeout)
  {
  	return -ENODEV;
  }
