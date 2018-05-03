From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: serial: custom baud rate
Date: Thu, 3 May 2018 18:27:14 +0000 (UTC)
Message-ID: <pcfka2$gie$1@blaine.gmane.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2018-05-03, Muni Sekhar <munisekharrms@gmail.com> wrote:

> If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
> Linux serial framework has any supporting method?

Sure, use the termios2 structure instead of the termios structure:

  #include <linux/termios.h>

  struct termios2 t;

  ioctl(fd, TCGETS2, &t)

  t.c_cflag &= ~CBAUD;
  t.c_cflag |= BOTHER;
  t.c_ispeed = baud;
  t.c_ospeed = baud;

  ioctl(fd, TCSETS2, &t)

[Not all devices/drivers support termios2]

-- 
Grant Edwards               grant.b.edwards        Yow! Are we live or on
                                  at               tape?
                              gmail.com            
