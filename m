From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] serial: samsung: Clear operation mode on UART shutdown
Date: Thu, 26 Mar 2015 23:19:20 +0100
Message-ID: <551485E8.2050406@collabora.co.uk>
References: <1426246731-13751-1-git-send-email-javier.martinez@collabora.co.uk> <550C1060.1040900@collabora.co.uk> <20150326215719.GA13985@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150326215719.GA13985@kroah.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Robert Baldyga <r.baldyga@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/26/2015 10:57 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 20, 2015 at 01:19:44PM +0100, Javier Martinez Canillas wrote:
>> > The offending commit landed in v4.0-rc1 so this fix is -rc material.
>> > 
>> >  drivers/tty/serial/samsung.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> > index af821a908720..cf08876922f1 100644
>> > --- a/drivers/tty/serial/samsung.c
>> > +++ b/drivers/tty/serial/samsung.c
>> > @@ -963,6 +963,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>> >  			free_irq(ourport->tx_irq, ourport);
>> >  		tx_enabled(port) = 0;
>> >  		ourport->tx_claimed = 0;
>> > +		ourport->tx_mode = 0;
>> >  	}
>> >  
>> >  	if (ourport->rx_claimed) {
>> > 
>> 
>> Any comments about this patch? 3.14-rc5 will most likely be released this weekend
>> so we are running out of time to fix this issue before 3.14 is released.
> 
> 3.14 was released months ago...
> 

err... I don't know what I was thinking when I wrote this, I obviously
meant 4.0. It seems the 3.1 prefix stuck in my head :)

Best regards,
Javier
