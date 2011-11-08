From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] RS485: fix inconsistencies in the meaning of some
 variables
Date: Tue, 8 Nov 2011 10:59:59 +0100
Message-ID: <20111108095959.GB31737@game.jcrosoft.org>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
 <4EB3A009.10502@evidence.eu.com> <4EB8F6B9.6010008@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EB8F6B9.6010008@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jesper Nilsson <Jesper.Nilsson@axis.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Claudio Scordino <claudio@evidence.eu.com>, Mikael Starvik <mikael.starvik@axis.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Darron Black <darron@griffin.net>, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On 10:30 Tue 08 Nov     , Nicolas Ferre wrote:
> On 11/04/2011 09:19 AM, Claudio Scordino :
> > Hi Alan, Hi Greg,
> > 
> > 	it seems that the crisv10.c and the atmel_serial.c serial
> > drivers interpret the fields of the serial_rs485 structure in a different
> > way.
> > 
> > In particular, it seems that crisv10.c uses SER_RS485_RTS_AFTER_SEND and
> > SER_RS485_RTS_ON_SEND for the _logic value_ of the RTS pin;
> > atmel_serial.c, instead, uses these values to know if a _delay_ must be
> > set before and after sending.
> 
> It seems sensible, but, on the other hand, I fear that this is a big
> change in the user interface: If people are already relying on this for
> their application, this can be difficult to understand the change. Can't
> we imagine an smoother migration path?
> 
> It seems from de6f86ce5 that 16C950 may also use rs485 mode (with
> another signal that RTS BTW)...
> 
> See comments online...
> 
> > This patch makes the usage of these variables consistent across all
> > drivers and fixes the Documentation as well.
> > In particular, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will
> > be used to set the logic value of the RTS pin (as in the crisv10.c
> > driver); the delay is understood by looking only at the value of
> > delay_rts_before_send and delay_rts_after_send.
> > 
> > Best regards,
> > 
> > 	Claudio
> > 
> > 
> > Subject: RS485: fix inconsistencies in the meaning of some variables
> > From: Claudio Scordino <claudio@evidence.eu.com>
> > 
> > The crisv10.c and the atmel_serial.c serial drivers interpret the fields
> > of the serial_rs485 structure in a different way.
> > In particular, crisv10.c uses SER_RS485_RTS_AFTER_SEND and 
> > SER_RS485_RTS_ON_SEND for the voltage of the RTS pin; atmel_serial.c, instead,
> > uses these values to know if a delay must be set before and after sending.
> > This patch makes the usage of these variables consistent across all drivers and
> > fixes the Documentation as well.
> >>From now on, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will be used to
> > set the voltage of the RTS pin (as in the crisv10.c driver); the delay will be
> > understood by looking only at the value of delay_rts_before_send and 
> > delay_rts_after_send.
> 
> Ok, but don't you think that the flags names are not so much
> self-explanatory for this new meaning?
> 
> What about:
> SER_RS485_RTS_LEVEL_DURING_SEND
> SER_RS485_RTS_VALUE_DURING_SEND (maybe too vague?)
> SER_RS485_RTS_LOGICAL_VALUE_DURING_SEND (maybe too long?)
> 
> Moreover, can't we just use one property for this? I mean, if RTS
> logical value is high during the sending of data, can it mean that RTS
> will be low before and after? And the other way around: if the signal is
> low during data send, will it be high before and after?
> 
> Here again, changing the user interface is not a good idea, so I fear
> that it can be a show stopper.
agreed with nicolas

Best Regards,
J.
