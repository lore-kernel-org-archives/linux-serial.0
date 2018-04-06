From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: uart throughput
Date: Fri, 6 Apr 2018 12:42:47 +0100
Message-ID: <20180406124247.551e26a9@alans-desktop>
References: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

> The primary factor affecting UART throughput is the baud rate, apart
> from this any other factors affect the UART throughput?

UART
CPU power
interrupt latency


all the usual suspects.

> > For 4000000 bps uart baud rate, what should be the theoretical peak
> data throughput?
> 

Depends entirely what the uart is wired to, how it works and how the
driver is written. If you've got bidirectional communication going on
then you also need to consider latency and windowing.

For a raw transfer over a decent UART with DMA with no post-processing I'd
expect you can do the full line rate but it may eat a lot of CPU time.
The uart code isn't particularly optimal for that kind of usage. It's not
impossible to fix by fast-pathing the non N_TTY line discipline cases but
nobody has found it a big enough pain to bother.

Alan
