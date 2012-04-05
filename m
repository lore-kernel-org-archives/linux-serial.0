From: "Shankarmurthy, Akshay" <akshay.s-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] serial: 8250: Add cpufreq support
Date: Thu, 5 Apr 2012 10:40:55 +0000
Message-ID: <6F6B80BD2E18844D97BB4B51FE3705C831790EA0@DBDE01.ent.ti.com>
References: <1333433022-5455-1-git-send-email-akshay.s@ti.com>
	<20120403105530.7fa3bce7@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20120403105530.7fa3bce7-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org" <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org" <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, "alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Apr 03, 2012 at 15:25:30, Alan Cox wrote:
> > This patch was submitted 2 years ago but didn't make it to the mainline. Now i am reposting it.
> 
> Can you fix it instead of just reposting it ?
> 
> 
> > +#ifdef CONFIG_CPU_FREQ
> > +static int serial8250_cpufreq_transition(struct notifier_block *nb,
> > +					     unsigned long val, void *data)
> > +{
> > +	struct uart_8250_port *p;
> > +	struct uart_port *uport;
> 
> What is your locking model ?
> 

I will have a look at this and add the lock if necessary.

> 
> > +static inline void serial8250_cpufreq_deregister(struct uart_8250_port *p)
> 
> unregister

Ok. I will change it.

> 
> > +		ret = serial8250_cpufreq_register(uart);
> > +		if (ret < 0)
> > +			printk(KERN_ERR "Failed to add cpufreq notifier\n");
> 
> Why do this for devices that don't care.

This is taken care in the code. If the device's frequency doesn't change after the
change in the cpu frequency then it doesn't go for execution of the function "serial8250_set_termios".
It does execute only if the uart clk frequency is changed with a change in the cpu frequency. 
So registering this for the devices that doesn't care will not affect the system. 


Regards,
Akshay
    
 
