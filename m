From: =?ISO-8859-1?Q?Kijam_L=F3pez?= <kijamve@gmail.com>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Sun, 13 Apr 2014 20:51:56 -0430
Message-ID: <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:38255 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaDNBWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Apr 2014 21:22:17 -0400
In-Reply-To: <20140414012013.GA1882@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

The following code works for me correctly in Windows, but Linux does
not work. I am using the same PC, both operating systems are installed
native. I do not use virtual machine. I need to work on Linux. I have
tried in different linux distributions and does not work anywhere.

    // In the main class:
      QSerialPortInfo info =3D XXXX; // Generally in Linux:
/dev/ttyUSB0, in win: COM1
      QSerialPort serial;
      QObject::connect(&serial, SIGNAL(readyRead()), this,
SLOT(onReadyRead()), Qt::DirectConnection);
      QObject::connect(&serial, SIGNAL(bytesWritten(qint64)), this,
SLOT(onBytesWritten(qint64)), Qt::DirectConnection);
      QObject::connect(&serial,
SIGNAL(error(QSerialPort::SerialPortError)), this,
SLOT(onError(QSerialPort::SerialPortError)), Qt::DirectConnection);

      // Slot
      void MyClass::onReadyRead()
      {
            qDebug()<<"Signal onReadyRead";
            buffer_mutex.lock();
            buffer +=3D serial.readAll();
            qDebug()<<"Read: "<<qstr_to_hexstr(buffer);
            bufferNotEmpty.wakeAll();
            buffer_mutex.unlock();
      }

      void MyClass::onError(QSerialPort::SerialPortError error) {
            qCritical()<<"Serial Port Error: "<<(int)error;
      }

      void MyClass::onBytesWritten(qint64 size){
            qDebug()<<"onBytesWritten: "<<size;
      }


      // In another place I did:
      serial.setPort(info);
      if(!serial.open(QIODevice::ReadWrite))
            return false;

      qDebug()<<"Init Setting!...";

      if(!serial.setBaudRate(QSerialPort::Baud9600))
            qCritical()<<"Error in setBaudRate";
      if(!serial.setDataBits(QSerialPort::Data8))
            qCritical()<<"Error in setDataBits";
      if(!serial.setParity(QSerialPort::EvenParity))
            qCritical()<<"Error in setParity";
      if(!serial.setStopBits(QSerialPort::OneStop))
            qCritical()<<"Error in setStopBits";
      if(!serial.setFlowControl(QSerialPort::SoftwareControl))
            qCritical()<<"Error in setFlowControl";
      if(!serial.setDataTerminalReady(true))
            qCritical()<<"Error in setDataTerminalReady";

      qDebug()<<"Setting ready!...";

If sending 1 byte the device responds and sends the data correctly.

Example:

    // In the main class:
    const char enq[2] =3D {0x05, '\0'};
    serial.write (enq);

    // In onReadyRead:
    serial.readAll(); // Works on Win / Linux


If sent a more than 1 byte device does not respond the request in linux=
=2E

Example:

    // In the main class:
    const char command[6] =3D {0x02, 'S', '1', 0x03, 'a', '\0'};
    serial.write(command);

    // In onReadyRead
    serial.readAll(); // Works only in Win

This event is triggered only in windows. In linux it never works, not
received or arrives in bad format and never recognized the remote
device.

My log in Windows:

      {Debug}             Init Setting!...
      {Debug}             Setting ready!...
      {Debug}             Write:  " 0x05 "
      {Debug}             onBytesWritten:  1
      {Debug}             buffer wait!...
      {Debug}                  Signal onReadyRead
      {Debug}                  Read:  " 0x02 `@ 0x03 #"
      {Debug}                  buffer size:  5
      {Critical}            Serial Port Error:  0
      {Debug}             Write:  " 0x02 S1 0x03 a"
      {Debug}             onBytesWritten:  5
      {Debug}             buffer wait!...
      {Debug}             Signal onReadyRead
      {Debug}             Read:  " 0x02 S100 0x0A 00000000000000000
0x0A 00000479"
      {Debug}             buffer size:  32
      {Debug}             buffer wait!...
      {Debug}             Signal onReadyRead
      {Debug}             Read:  " 0x02 S100 0x0A 00000000000000000
0x0A 00000479 0x0A 00000 0x0A 00000330 0x0A 00000 0x0A 0061 0x0A 0000
0x0A "
      {Debug}             buffer size:  64
      {Debug}             Signal onReadyRead
      {Debug}             buffer wait!...
      {Debug}             Read:  " 0x02 S100 0x0A 00000000000000000
0x0A 00000479 0x0A 00000 0x0A 00000330 0x0A 00000 0x0A 0061 0x0A 0000
0x0A X-XXXXXXXX 0x0A XXXXXXXXX 0x0A 221715 0x0A 120414 0x0A  0x03
0x1B "
      {Debug}             buffer size:  103
      {Critical}            Serial Port Error:  0

(I replace the actual response of the device by the 'X' characters)

My log in Linux:

      {Debug}             Init Setting!...
      {Debug}             Setting ready!...
      {Debug}             Write:  " 0x05 "
      {Debug}             onBytesWritten:  1
      {Debug}             buffer wait!...
      {Debug}                  Signal onReadyRead
      {Debug}                  Read:  " 0x02 `@ 0x03 #"
      {Debug}                  buffer size:  5
      {Critical}            Serial Port Error:  0
      {Debug}                  Write:  " 0x02 S1 0x03 a"
      {Debug}                  onBytesWritten:  5
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             buffer wait!...
      {Debug}             timeout!... (15 sec for timeout)

USB Serial Adapter: CH340

      In Windows: USB\VID_1A86&PID_7523&REV_0254
      In Linux:
            Apr 13 01:16:58 kali kernel: [47844.260136] usb 2-1: new
full-speed USB device number 16 using uhci_hcd
            Apr 13 01:16:58 kali kernel: [47844.428098] usb 2-1: New
USB device found, idVendor=3D1a86, idProduct=3D7523
            Apr 13 01:16:58 kali kernel: [47844.428115] usb 2-1: New
USB device strings: Mfr=3D0, Product=3D2, SerialNumber=3D0
            Apr 13 01:16:58 kali kernel: [47844.428126] usb 2-1:
Product: USB2.0-Ser!
            Apr 13 01:16:58 kali kernel: [47844.431268] ch341 2-1:1.0:
ch341-uart converter detected
            Apr 13 01:16:58 kali kernel: [47844.445398] usb 2-1:
ch341-uart converter now attached to ttyUSB0
            Apr 13 01:16:58 kali mtp-probe: checking bus 2, device 16:
"/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1"
            Apr 13 01:16:58 kali mtp-probe: bus: 2, device: 16 was not
an MTP device


**More information 1:**

      Apr 13 04:10:55 kali kernel: [ 4872.627980] tty ttyUSB0:
serial_write - 1 byte(s)
      Apr 13 04:10:55 kali kernel: [ 4872.629763] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:55 kali kernel: [ 4872.629778] tty ttyUSB0:
serial_wait_until_sent
      Apr 13 04:10:55 kali kernel: [ 4872.638252] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:55 kali kernel: [ 4872.638267] tty ttyUSB0: serial_w=
rite_room
      Apr 13 04:10:55 kali kernel: [ 4872.638278] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:55 kali kernel: [ 4872.638287] tty ttyUSB0: serial_w=
rite_room
      Apr 13 04:10:55 kali kernel: [ 4872.639438] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:55 kali kernel: [ 4872.639458] tty ttyUSB0: serial_w=
rite_room
      Apr 13 04:10:55 kali kernel: [ 4872.639475] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:55 kali kernel: [ 4872.639488] tty ttyUSB0: serial_w=
rite_room
      Apr 13 04:10:56 kali kernel: [ 4873.641799] tty ttyUSB0:
serial_ioctl - cmd 0x540b
      Apr 13 04:10:56 kali kernel: [ 4873.646884] tty ttyUSB0:
serial_write - 5 byte(s)
      Apr 13 04:10:56 kali kernel: [ 4873.647152] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
      Apr 13 04:10:56 kali kernel: [ 4873.647176] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01
      Apr 13 04:10:56 kali kernel: [ 4873.647384] tty ttyUSB0:
serial_chars_in_buffer
      Apr 13 04:10:56 kali kernel: [ 4873.647401] tty ttyUSB0:
serial_wait_until_sent
      Apr 13 04:10:56 kali kernel: [ 4873.649144] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
      Apr 13 04:10:56 kali kernel: [ 4873.649166] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01
      Apr 13 04:10:56 kali kernel: [ 4873.692152] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
      Apr 13 04:10:56 kali kernel: [ 4873.692170] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01
      Apr 13 04:10:56 kali kernel: [ 4873.694133] ch341-uart ttyUSB0:
ch341_update_line_status - multiple status change
      Apr 13 04:10:56 kali kernel: [ 4873.694148] ch341-uart ttyUSB0:
ch341_update_line_status - delta=3D0x01

I rebuild ch341.c and add:

      if (!delta)
            return;

      dev_info(&port->dev, "%s - delta=3D0x%02X\n", __func__, delta); /=
/
<---- New Line

      if (delta & CH341_BIT_CTS)
            port->icount.cts++;
      if (delta & CH341_BIT_DSR)
            port->icount.dsr++;
      if (delta & CH341_BIT_RI)
            port->icount.rng++;
      if (delta & CH341_BIT_DCD) {
            port->icount.dcd++;
            tty =3D tty_port_tty_get(&port->port);
            if (tty) {
                  usb_serial_handle_dcd_change(port, tty,
                                    status & CH341_BIT_DCD);
                  tty_kref_put(tty);
            }
      }

delta=3D0x01 in the log is flag:

    #define CH341_BIT_CTS 0x01

**More information 2:**

In the thread of write / read I hope for wakeAll, running on
onReadyRead. If you pass a second make a readAll before checking if
the buffer is empty. example:

      // In the main class:
      QWaitCondition bufferNotEmpty;

      // In my function write/read:
      serial.write(data, size);
      buffer_mutex.lock();
      while(time(NULL)-timeStart<timeoutWait && serial.isOpen()) {
            buffer +=3D serial.readAll();
            if(buffer.count()>0){
                  qDebug()<<"buffer size: "<<buffer.count();
                  //Interprete the buffer here...

                  if(bufferComplete)
                        break;
            }
            qDebug()<<"buffer wait!...";
            bufferNotEmpty.wait(&buffer_mutex, 1000);
      }
      buffer.clear();
      buffer_mutex.unlock();

**More information 3:**

My Kernel is 3.12.6, but i updated from GitHub this file an rebuild
this drivers:

https://github.com/torvalds/linux/blob/master/drivers/usb/serial/ch341.=
c
https://github.com/torvalds/linux/blob/master/drivers/usb/serial/usb-se=
rial.c
(commit d9a38a8741fdffabc32e6d0943b1cdcf22712bec)



PD: Sorry for my English, try to do my best with Google Translator :(..=
=2E

_____________________________
Atentamente
Lic. Kijam L=F3pez
P=E1gina Web
Curriculum Vitae


2014-04-13 20:50 GMT-04:30 Greg KH <gregkh@linuxfoundation.org>:
> On Sun, Apr 13, 2014 at 08:19:11PM -0430, Kijam L=F3pez wrote:
>> Hi!, I'm having trouble with this adapter, and lately I think it's t=
he
>> driver. Here I leave a link where I report the problem:
>>
>> http://stackoverflow.com/questions/23040820/driver-ch341-usb-adapter=
-serial-port-or-qserialport-not-works-in-linux
>
> How about asking the question here, and not on some random web site,
> where there's nothing we can do about it...
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
