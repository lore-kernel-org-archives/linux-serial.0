From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: serial: custom baud rate
Date: Thu, 3 May 2018 13:54:01 -0400
Message-ID: <20180503175401.GD29205@thunk.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2018 at 06:09:13PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> From include/asm-generic/termbits.h , I see baudrate can be one of the
> standard values: 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800,
> 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000,
> 576000, 921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000,
> 3500000, 4000000.
> 
> If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
> Linux serial framework has any supporting method?

See the setserial man page:t

	https://linux.die.net/man/8/setserial

Not all serial devices support the spd_cust and divisor, however.  In
general, only devices where the kernel directly programs the
8250/16450/16550 UART directly will support this feature.

							- Ted
