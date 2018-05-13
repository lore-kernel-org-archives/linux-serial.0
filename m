From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: serial: custom baud rate
Date: Sun, 13 May 2018 20:57:26 +0100
Message-ID: <20180513205726.5029c88a@alans-desktop>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
        <pcfka2$gie$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <pcfka2$gie$1@blaine.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 3 May 2018 18:27:14 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> On 2018-05-03, Muni Sekhar <munisekharrms@gmail.com> wrote:
> 
> > If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
> > Linux serial framework has any supporting method?  
> 
> Sure, use the termios2 structure instead of the termios structure:
> 
>   #include <linux/termios.h>
> 
>   struct termios2 t;
> 
>   ioctl(fd, TCGETS2, &t)
> 
>   t.c_cflag &= ~CBAUD;
>   t.c_cflag |= BOTHER;
>   t.c_ispeed = baud;
>   t.c_ospeed = baud;
> 
>   ioctl(fd, TCSETS2, &t)
> 
> [Not all devices/drivers support termios2]

That shouldn't be true - all devices get passed ispeed/ospeed and
everything in tree was using the correct fields as far as I could tell
last time I checked this

Alan
