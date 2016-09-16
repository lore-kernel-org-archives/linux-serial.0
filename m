From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/4] serial: 8250: of: Load TX FIFO Load Size from DT
Date: Fri, 16 Sep 2016 22:51:54 +0200
Message-ID: <2077078.euc60HfglH@wuerfel>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com> <20160916192039.GB30710@rob-hp-laptop> <2e79f6cc-8d9a-b9b7-884c-6916b2e74d64@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2e79f6cc-8d9a-b9b7-884c-6916b2e74d64-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, anton.wuerfel-d40JDW7QUjc@public.gmane.org, phillip.raffeck-d40JDW7QUjc@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, dongsheng.wang-3arQi8VN3Tc@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Friday, September 16, 2016 3:52:55 PM CEST Thor Thayer wrote:
> >
> >
> Yes, I originally had it implemented using that function but then I 
> realized the port8250.tx_loadsz is an unsigned int and therefore can 
> change size on different platforms.
> 
> The assignment handles that. In retrospect, I should probably change 
> this to a of_property_read_u8() anyway so that it won't cause compile 
> warnings in the smaller architectures.
> 
> Thank you for reviewing and the comments.

We don't support architectures with 'int' types other than 32 bits,
so the version that Rob suggested is guaranteed to work everywhere.

Using u8 properties seems like a bad idea in general, better stay
with 32-bit units for consistency.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
