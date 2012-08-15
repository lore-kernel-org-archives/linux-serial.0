From: Tomas Hlavacek <tmshlvck@gmail.com>
Subject: Re: [PATCH 1/1] [RFC] uartclk from serial_core exposed to sysfs
Date: Wed, 15 Aug 2012 19:09:05 +0200
Message-ID: <CAEB7QLCgUJzq+7nqDoBLp8hRpKXAxhajPFnMEZ82MfzesUqZ6A@mail.gmail.com>
References: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
	<1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
	<201208141450.23453.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201208141450.23453.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Marek,

On Tue, Aug 14, 2012 at 2:50 PM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
> Dear Tomas Hlavacek,
>
>> +static ssize_t get_attr_uartclk(struct device *dev,
>> +             struct device_attribute *attr, char *buf)
>> +{
>> +     int ret;
>> +
>> +     struct uart_state *state =3D (struct uart_state *)(dev_get_drv=
data(dev));
>
> You don't need this cast here.

Yes, you are right. Thanks.

>
>> +     mutex_lock(&state->port.mutex);
>> +     ret =3D snprintf(buf, PAGE_SIZE, "%d\n", state->uart_port->uar=
tclk);
>
> Do you really need such a large buffer (PAGE_SIZE) ?

Well no, but I believe that I get the buffer of length equal to
PAGE_SIZE anyway. Documentation/filesystems/sysfs.txt says so on line
179.

>
>> +     mutex_unlock(&state->port.mutex);
>> +     return ret;
>> +}
>> +
>> +static ssize_t set_attr_uartclk(struct device *dev,
>> +             struct device_attribute *attr, const char *buf, size_t=
 count)
>> +{
>> +     struct uart_state *state =3D (struct uart_state *)(dev_get_drv=
data(dev));
>> +     unsigned int val;
>> +     int ret;
>> +
>> +     ret =3D kstrtouint(buf, 10, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     mutex_lock(&state->port.mutex);
>> +
>> +     /*
>> +      * Check value: baud_base has to be more than 9600
>> +      * and uartclock =3D baud_base * 16 .
>> +      */
>> +     if (val >=3D 153600)
>> +             state->uart_port->uartclk =3D val;
>
> This magic value here would use some documentation.

OK. Do you think this would be sufficient comment?:

/*
 * Check value: baud_base does not make sense to be set below 9600
 * and since uartclock =3D (baud_base * 16) it has to be equal or great=
er than
 * 9600 * 16 =3D 153600.
 */

PATCHv2 follows.

Tomas


--=20
Tom=C3=A1=C5=A1 Hlav=C3=A1=C4=8Dek <tmshlvck@gmail.com>
