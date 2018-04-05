From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: uart throughput
Date: Thu, 5 Apr 2018 21:19:53 +0200
Message-ID: <20180405191953.GA19801@kroah.com>
References: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 05, 2018 at 10:08:14PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> 
> I’ve an uart hardware implemented on Xilinx FPGA image and it connects
> to host CPU(Intel based chip) on PCIe bus in Linux platform.
> 
> 
> The following parameters were fixed or varied when measuring the UART
> throughput in internal loopback mode(UART_RX and UART_TX pins were
> internally connected):
> 
> 
> •             Uart baud rate
> •             Parity Bit
> •             Stop Bit(s)
> 
> 
> The primary factor affecting UART throughput is the baud rate, apart
> from this any other factors affect the UART throughput?
> 
> For 4000000 bps uart baud rate, what should be the theoretical peak
> data throughput?

Um, you do know what "baud rate" means, right?  And how stop bits and
parity are related to a baud rate?

Throughput all depends on a whole raft of different things.  How exactly
have you measured this and where did you find any performance
bottlenecks?

thanks,

greg k-h
