From: "Josh Hammond" <jhammond-qGaTmy9+pjn8wb0/L2CcF0B+6BGkLq7r@public.gmane.org>
Subject: RE: Accessing USB thermometer sensor
Date: Tue, 24 Jun 2008 09:18:01 +0200 (CEST)
Message-ID: <c2b560bd4b1cb112f2ca096ee6858dc2.squirrel@webmail.vp44.net>
Reply-To: jhammond-qGaTmy9+pjn8wb0/L2CcF0B+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, June 23, 2008 9:20 am, Tosoni wrote:
>> the right direction to be able to read the temperature from command line?
>> Josh
>>
> Reading a serial device from the commannd line is not easy.
> First because each command you type closes the port after running and so it
> flushes buffers.
>
> I would suggest using shell parenthesis to group the commands
> Use stty to set the port to raw mode etc.
> Use 'echo' and 'dd' which is like 'cat' but much more configurable for
buffer sizes
> something like:
> ( stty 9600 raw; echo 'request'; dd bs=1 count=10 >response.out)
</dev/serialusb >&0
>
>

Unfortunately it doesn't seem to work.
This is the general output (I tried several tty speeds):

osmosis:/home/josh# ( stty 9600 raw; echo 'request'; dd bs=1 count=10
>response.out) < /dev/ttyUSB0 >&0

bash: echo: write error: Bad file descriptor
0+0 records in
0+0 records out
0 bytes (0 B) copied, 32.3506 s, 0.0 kB/s



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
