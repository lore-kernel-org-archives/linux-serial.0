From: "Francisco M. Marzoa Alonso" <fmmarzoa@gmx.net>
Subject: Migrating from Windows to LiNUX
Date: Fri, 20 Aug 2004 10:25:48 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408201025.48492.fmmarzoa@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48578 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267825AbUHTISV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Aug 2004 04:18:21 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm migrating from Windows to LiNUX an application that communicates with an 
RFID reader through serial port to update device's firmware, but I've lost 
more than eight hours trying to read a char from the device without success. 

The only thing I've accomplished is that the device enters in the firmware 
update mode, that's done simply setting the RTS to 1 and then to 0, but I've 
not been able to read no char from the device.

I think there may be a problem during the configuration of the serial port. 
This is the Windows application's function that makes it:

int SetCommParams(HANDLE HND, DWORD baudrate, BYTE parity, BYTE databits, BYTE 
stopbits) {
        DCB mode;
        COMMTIMEOUTS Tout;    //Struct for setting timeouts

        mode.DCBlength=sizeof(mode);
        mode.BaudRate=baudrate;
        mode.fBinary=1;
        mode.fParity=0;
        mode.fOutxCtsFlow=0;
        mode.fOutxDsrFlow=0;
        mode.fDtrControl=DTR_CONTROL_DISABLE;
        mode.fDsrSensitivity=0;
        mode.fTXContinueOnXoff=0;
        mode.fOutX=0;
        mode.fInX=0;
        mode.fErrorChar=0;
        mode.fNull=0;
        mode.fRtsControl=RTS_CONTROL_DISABLE;
        mode.fAbortOnError=0;
        mode.XonLim=1;
        mode.XoffLim=1;
        mode.ByteSize=databits;
        mode.Parity=parity;
        mode.StopBits=stopbits;
        mode.EofChar = 0;
        mode.XonChar = 1;
        mode.XoffChar = 0;
        mode.EvtChar = 0;

        if ( ! SetCommState(HND,&mode) )
                return 0;

        if ( ! SetCommMask(HND,EV_TXEMPTY) )
                return 0;

        Tout.ReadIntervalTimeout=1;
        Tout.ReadTotalTimeoutMultiplier=100;
        Tout.ReadTotalTimeoutConstant=1;
        Tout.WriteTotalTimeoutMultiplier=1;
        Tout.WriteTotalTimeoutConstant=100;

        if ( ! SetCommTimeouts(HND,&Tout) )
                return 0;

        if ( ! EscapeCommFunction(HND,CLRDTR) )
                return 0;

        if ( ! EscapeCommFunction(HND,CLRRTS) )
                return 0;

        return 1;
}



And here is the version that I've programmed for LiNUX:


int SetCommParams(HANDLE HND, DWORD baudrate, BYTE parity, BYTE databits, BYTE 
stopbits) {
	speed_t l_baudrate;
	int l_databits, rtn;
	struct termios CommParams;

	// Convert baudrate to LiNUX's baudrate
	switch (baudrate) {
		case 0:
			l_baudrate = B0;
			break;
		case 50:
			l_baudrate = B50;
			break;
		case 75:
			l_baudrate = B75;
			break;
		case 110:
			l_baudrate = B110;
			break;
		case 134:
			l_baudrate = B134;
			break;
		case 150:
			l_baudrate = B150;
			break;
		case 200:
			l_baudrate = B200;
			break;
		case 300:
			l_baudrate = B300;
			break;
		case 600:
			l_baudrate = B600;
			break;
		case 1200:
			l_baudrate = B1200;
			break;
		case 1800:
			l_baudrate = B1800;
			break;
		case 2400:
			l_baudrate = B2400;
			break;
		case 4800:
			l_baudrate = B4800;
			break;
		case 9600:
			l_baudrate = B9600;
			break;
		case 19200:
			l_baudrate = B19200;
			break;
		case 38400:
			l_baudrate = B38400;
			break;
		case 57600:
			l_baudrate = B57600;
			break;
		case 115200:
			l_baudrate = B115200;
			break;
		case 230400:
			l_baudrate = B230400;
			break;
		default:
			// Invalid baudrate
			return -1;
	}

	// Convert databits to LiNUX's databits
	switch (databits) {
		case 5:
			l_databits = CS5;
			break;
		case 6:
			l_databits = CS6;
			break;
		case 7:
			l_databits = CS7;
			break;
		case 8:
			l_databits = CS8;
			break;
		default:
			// Invalid databits
			return -1;
	}


	CommParams.c_cflag = l_baudrate | l_databits | CREAD | CLOCAL;
	// Disable RTS CTS flow control
	CommParams.c_cflag &= ~CRTSCTS;
	CommParams.c_iflag = 0; // Raw input
	CommParams.c_oflag = 0; // Raw output

	CommParams.c_lflag &= ~ICANON; // Disable canonical processing
	CommParams.c_lflag &= ~ISIG; // Disable signals
	CommParams.c_lflag &= ~ECHO; // Disable echoing

	CommParams.c_cc[VINTR]    = 0;
	CommParams.c_cc[VQUIT]    = 0;
	CommParams.c_cc[VERASE]   = 0;
	CommParams.c_cc[VKILL]    = 0;
	CommParams.c_cc[VEOF]     = 4;
	CommParams.c_cc[VTIME]    = 100;
	CommParams.c_cc[VMIN]     = 0;
	CommParams.c_cc[VSWTC]    = 0;
	CommParams.c_cc[VSTART]   = 0;
	CommParams.c_cc[VSTOP]    = 0;
	CommParams.c_cc[VSUSP]    = 0;
	CommParams.c_cc[VEOL]     = 0;
	CommParams.c_cc[VREPRINT] = 0;
	CommParams.c_cc[VDISCARD] = 0;
	CommParams.c_cc[VWERASE]  = 0;
	CommParams.c_cc[VLNEXT]   = 0;
	CommParams.c_cc[VEOL2]    = 0;

        tcflush(HND, TCIFLUSH);

	rtn = tcsetattr(HND,TCSANOW,&CommParams);

        //if ( tcsetattr(HND,TCSANOW,&CommParams) < 0 )
	if ( rtn < 0 )
		return 0; // Error setting device attributes


	if ( ! CommClearRTS ( HND ) )
		return 0;

	if ( ! CommClearDTR ( HND ) )
		return 0;


	// TODO: A LOT

	// If we reach this point, everything should be ok
	return 1;
}


The following is the read routine under Windows:

int CommReadChar(HANDLE HND, int Wait, unsigned char* Data)
{
        unsigned long tick_end;
        DWORD Flag_RX;

        Flag_RX=0;
        tick_end = GetTickCount()+Wait;

        do {
                ReadFile( HND, Data, 1, &Flag_RX, NULL );
        } while( (GetTickCount()<tick_end) && (Flag_RX==0) );

        return Flag_RX;
}

And here's the one that I've wroten for LiNUX:

int CommReadChar (HANDLE HND, int Wait, unsigned char* Data) {
	struct timeval TOut;
	fd_set readfs;

	FD_ZERO(&readfs);
	FD_SET (HND, &readfs);

	TOut.tv_sec = 0;
	TOut.tv_usec = Wait;

	if ( select ( 1, &readfs, NULL, NULL, &TOut ) ) {
		return ( read (HND, &Data, 1) );
	} else {
		perror ("CommReadChar TIMEOUT while waiting for reading");
		return 0;
	}
}


The rest of the source implied is basically the same on both systems and I 
think is irrelevant for the matter. The point is that the first time I try to 
read the port calling CommReadChar I get a timeout from the select, but next 
calls to that function gives a worse "Illegal seek" error.

If I change the select line by:

if ( select ( 1, &readfs, NULL, NULL, NULL ) ) { ...

It never returns from that point. I've not here a serial protocol analizer 
that supports the 115200 bps that must be used with this device in firmware 
update mode, but under windows I really obtain a char from device at the same 
point, so I think there should be some difference at SetCommParams.

Thanks in advance if someone can give me a hint.

P.S. Under LiNUX 'HANDLE' is defined as 'int' to use it with 'open' function, 
under windows is defined as DWORD by the system. Ahm, and BTW, excuse my poor 
english.




